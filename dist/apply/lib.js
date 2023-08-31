window.lib = function(arg$){
  var def, i18n;
  def = arg$.def, i18n = arg$.i18n;
  return {
    idx: function(arg$){
      var prj, idx;
      prj = arg$.prj;
      idx = (prj.system || {}).idx;
      if (!(idx != null)) {
        return '???';
      } else if (isNaN(idx)) {
        return idx;
      } else {
        return "2024-" + (idx + "").padStart(3, "0");
      }
    },
    info: function(arg$){
      var prj, _, form, lng, data;
      prj = arg$.prj;
      _ = function(v){
        return (v ? v.v : v) || 'n/a';
      };
      form = ((prj.detail || {}).custom || {})[def.config.alias || def.slug] || {};
      lng = i18n.getLanguage();
      data = {
        name: _(form["title_en"]),
        description: _(form["description_en"]),
        team: {
          name: _(form["speaker"]),
          taxid: '',
          pic: _(form["speaker"])
        },
        contact: {
          email: '',
          name: '',
          mobile: '',
          title: '',
          addr: ''
        },
        budget: {
          total: 0,
          "expected-subsidy": 0
        }
      };
      if (/zh/.exec(lng)) {
        data.name = _(form["title_zh"]);
        data.description = _(form["description_zh"]);
      }
      return data;
    }
  };
};
