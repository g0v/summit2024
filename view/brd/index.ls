main_desc =
  en: 'g0v Summit is an international conference hosted by g0v once every two years. Due to the impact of the pandemic, it was suspended in 2022. Next year, the g0v Summit 2024 will encourage your passionate civic spirit.'
  zh: 'g0v Summit 是由 g0v 台灣零時政府社群主辦的大型國際會議，慣例為 2 年一次。受到疫情影響，2022 年停辦。明年，Summit 2024 將喚醒你體內的熱血公民魂。'
ldc.register \pagecfg, <[]> ->
  locales:
    en:
      "台灣零時政府社群主辦的大型國際會議": main_desc.en
      "線上投稿頁面": "Submission"
      "建立提案": "Create Submission"
      "我的提案": "My Proposals"
      "提案清單": "Proposal List"
      "更多提案": "More Proposals"
      "隱私權政策": "Privacy Policy"
      "使用者條款": "Term of Use"
    "zh-TW":
      "台灣零時政府社群主辦的大型國際會議": main_desc.zh
      "線上投稿頁面": "線上投稿頁面"
      "建立提案": "建立提案"
      "我的提案": "我的提案"
      "提案清單": "提案清單"
      "更多提案": "更多提案"
      "隱私權政策": "隱私權政策"
      "使用者條款": "使用者條款"
ldc.register <[pagelocals core]>, ({pagelocals, core}) ->
  <- core.init!then _
  lc = {lng: \zh}
  view = new ldview do
    root: document.body
    handler:
      prj:
        list: -> pagelocals.prjs
        key: -> it.slug
        view:
          handler:
            name: ({node, ctx}) ->
              node.innerText = ctx.name[lc.lng] or ctx.name.en or ctx.name.zh or ''
              if pagelocals.viewer => node.setAttribute \href, "/prj/#{ctx.slug}"
              else node.removeAttribute \href
            desc: ({node, ctx}) ->
              text = (ctx.desc[lc.lng] or ctx.desc.en or ctx.desc.zh or '')
              text = if text.length > 80 => text.substring(0, 80) + '...' else text
              node.innerText = text
  setlng = (lng) ->
    lc.lng = if /zh/.exec(lng) => \zh else \en
    view.render!
  setlng core.i18n.language
  core.i18n.on \languageChanged, (lng) -> setlng lng
  _jf.flush!
