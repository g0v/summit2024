window.lib = ({def, i18n}) ->
  fields: open: fields
  /*
  mask: view:
    email: true
    time_attend: true
    visa_assistance: true
    diverse_traits: true
    workshop_equipment: true
    where_get: true
    something_to_say: true
  */
  idx: ({prj}) ->
    idx = (prj.system or {}).idx
    if !(idx?) => \???
    else if isNaN(idx) => idx
    else "2024-" + "#idx".padStart(3, "0")
  info: ({prj}) ->
    _ = (v) -> (if v => v.v else v) or 'n/a'
    gv = (v) -> if v => v.v else v
    form = ((prj.detail or {}).custom or {})[def.config.alias or def.slug] or {}
    lng = i18n.getLanguage!
    data =
      name: gv(form["title_en"]) or gv(form["title_zh"]) or 'n/a'
      description: gv(form["description_en"]) or gv(form["description_zh"]) or 'n/a'
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
      data.name = gv(form["title_zh"]) or gv(form["title_en"]) or 'n/a'
      data.description = gv(form["description_zh"]) or gv(form["description_en"]) or 'n/a'
    data
