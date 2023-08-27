module.exports =
  pkg:
    name: "@g0v/summit2024"
    extend: name: "@grantdash/prj.tdb"
    dependencies: [ {name: "ldview"} ]
    i18n: en: i18n-res.en, "zh-TW": i18n-res["zh-TW"]
  init: ({root, ctx, manager, pubsub, i18n, t}) ->
    pubsub.fire \init, mod({root, ctx, t, pubsub, manager, bi: @_instance})

mod = ({root, ctx, t, pubsub, manager, bi}) ->
  info: subset: "open", fields: fields
  render: ->
  init: (base) ->
    @formmgr = base.formmgr
    block.i18n.add-resource-bundle \en, "", i18n-res.en, true, true
    block.i18n.add-resource-bundle \zh-TW, "", i18n-res["zh-TW"], true, true
    bi.transform \i18n
  brief: ->
    name: @formmgr.content("title_zh")
    description: @formmgr.content("description_zh")
