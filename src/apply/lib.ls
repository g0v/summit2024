window.lib = ({def, i18n}) ->
  idx: ({prj}) ->
    idx = (prj.system or {}).idx
    if !(idx?) => \???
    else if isNaN(idx) => idx
    else "2024-" + "#idx".padStart(3, "0")
  info: ({prj}) ->
    _ = (v) -> (if v => v.v else v) or 'n/a'
    form = ((prj.detail or {}).custom or {})[def.config.alias or def.slug] or {}
    lng = i18n.getLanguage!
    data =
      name: _(form["title_en"])
      description: _(form["description_en"])
      team:
        name: _(form["name"])
        taxid: ''
        pic: _(form["name"])
      contact:
        email: form["email"]
        name: form["name"]
        mobile: ''
        title: form["affiliation"]
        addr: ''
      budget:
        total: 0
        "expected-subsidy": 0
    if /zh/.exec(lng) =>
      data.name = _(form["title_zh"])
      data.description = _(form["description_zh"])
    data
