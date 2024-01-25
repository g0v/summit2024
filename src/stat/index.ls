module.exports =
  pkg:
    extend: name: '@grantdash/judge', path: 'common'
    dependencies: [
      {name: "ldfile"}
      {name: "csv4xls"}
      {name: "@plotdb/sheet"}
      {name: "@plotdb/sheet", type: \css}
    ]
  render: ->
    console.log @prjs
    ks = <[theme where_get keywords_2 keywords_3]>
    h = {langs: {}}
    for k in ks => h[k] = {}
    count-active = @prjs.filter(-> it.state == \active).length
    prjs = @prjs.map -> it.detail.custom.open
    prjs.map (p) -> h.langs[p.language] = (h.langs[p.language] or 0) + 1
    data = []
    for i from 0 til ks.length =>
      field = ks[i]
      prjs.map (p) ->
        if !p[field] => return
        p[field].list.map (t) -> h[field][t] = (h[field][t] or 0) + 1
        if p[field].{}other.enabled and (t = p[field].other.text) => h[field][t] = (h[field][t] or 0) + 1
      list = [[k,v] for k,v of h[field]]
      list.sort (a,b) -> b.1 - a.1
      data[][0][i * 2] = field
      data[][0][i * 2 + 1] = "數量"
      for j from 0 til list.length =>
        data[][j + 1][i * 2 + 0] = list[j].0
        data[][j + 1][i * 2 + 1] = list[j].1
    i = ks.length
    data[][0][i * 2] = "目前投稿量"
    data[][0][i * 2 + 1] = count-active
    @sheet.data data
    @view.render!

  init: ({root, ctx, manager, pubsub}) ->
    {sheet} = ctx
    ({core}) <~ servebase.corectx _
    submod = {}
    @infos = []
    pubsub.fire \init, {mod: @, submod, ctx}
    @view = view = new ldview do
      root: root
      init: sheet: ({node}) ~> @sheet = new sheet root: node
