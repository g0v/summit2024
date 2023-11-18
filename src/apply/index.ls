module.exports =
  pkg:
    name: "@g0v/summit2024"
    extend: name: "@grantdash/prj.tdb"
    dependencies: [ {name: "ldview"} ]
    i18n: en: i18n-res.en, "zh-TW": i18n-res["zh-TW"]
  init: ({root, ctx, manager, pubsub, i18n, t}) ->
    pubsub.fire \init, mod({root, ctx, t, pubsub, manager, i18n, bi: @_instance})

mod = ({root, ctx, t, pubsub, manager, bi, i18n}) ->
  info: subset: "open", fields: fields
  render: -> @_ldview.render!
  init: (base) ->
    @formmgr = base.formmgr
    block.i18n.add-resource-bundle \en, "", i18n-res.en, true, true
    block.i18n.add-resource-bundle \zh-TW, "", i18n-res["zh-TW"], true, true
    bi.transform \i18n
    block.i18n.module.on \languageChanged, ~>
      @optin!
      @_ldview.render!
    @_ldview = view = new ldview do
      init-render: false
      root: root
      handler:
        visibility: ({node}) ~>
          name = node.getAttribute \data-name
          node.classList.toggle \d-none, !(@{}_visibility[name])
        "for-lng": ({node}) ~>
          show = (i18n.get-language! or '').indexOf(node.getAttribute(\data-lng)) == 0
          node.classList.toggle \d-none, !show

    @formmgr.on \change, debounce 350, ~> @optin!
    @optin!

  optin: ->
    # targets is required/visible(based on `is-required` and `visible` field) only if name = val
    dependency = ({source, values, targets, is-required, visible}) ~>
      itf = fields[source].itf
      content = itf.content!
      content = if Array.isArray(content) => content else [content]
      active = !!content.filter((c) -> if Array.isArray(values) => (c in values) else (c == values)).length
      required = if !is-required => !active else active
      visible = if !visible => !active else active
      for tgt in targets =>
        @{}_visibility[tgt] = visible
        if !(fields[tgt] and (o = fields[tgt].itf)) => continue
        c = o.serialize!
        c.is-required = active
        o.deserialize c

    plugin-run = (k, v, p = {}) ->
      if p.type == \dependency =>
        cfg = p.{}config{values, is-required, visible}
        cfg <<< if p.config.source => {source: p.config.source, targets: [k]}
        else {source: k, targets: p.config.targets}
        dependency cfg

    # NOTE this won't trigger plugins in cops and cofs
    for k,v of fields =>
      ((v.meta or {}).plugin or []).map -> plugin-run(k, v, it)

    # tweak required status of fields containing variant based on lng
    lng = block.i18n.language
    for k,v of fields =>
      if !(val = ((v.meta or {}).config or {}).variant) => continue
      o = v.itf
      m = lng.startsWith(val) or val.startsWith(lng)
      c = o.serialize!
      c.is-required = m
      o.deserialize c

    @_ldview.render \visibility

  brief: ->
    lng = i18n.getLanguage!
    if /zh/.exec(lng) =>
      name: @formmgr.content("title_zh")
      description: @formmgr.content("description_zh")
    else =>
      name: @formmgr.content("title_en")
      description: @formmgr.content("description_en")
