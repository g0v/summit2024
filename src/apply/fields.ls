fields = {} <<<
  "agreement_accept":
    type: "@makeform/agreement"
    meta:
      title: \我已經閱讀完並同意以上資訊
      is-required: true
      config:
        value: "是"

  "agreement_no_short":
    type: "@makeform/agreement"
    meta:
      title: \我已明確知悉並會遵守在本表單中的任何欄位中不要使用任何縮網址
      is-required: true
      config:
        value: "是"

  "title_zh":
    meta: 
      title: \您的投稿標題
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 20, method: \simple-word}]
      is-required: true
      config:
        variant: \zh
        limitation: \上限20字

  "title_en":
    meta:
      title: \您的投稿標題
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 20, method: \simple-word}]
      is-required: true
      config:
        variant: \en
        limitation: \上限20字

  "description_zh":
    type: \@makeform/textarea
    meta:
      title: \投稿的內容說明
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 200, method: \simple-word}]
      is-required: true
      config:
        variant: \zh
        show-markdown-option: true
        limitation: \上限200字

  "description_en":
    type: \@makeform/textarea
    meta:
      title: \投稿的內容說明
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 200, method: \simple-word}]
      config:
        variant: \en
        show-markdown-option: true
        limitation: \上限200字

  "theme":
    type: \@makeform/checkbox
    meta:
      title: "請選擇與你投稿內容相關連之 g0v Summit 2024 主軸"
      is-required: true
      config:
        values: [
          "Nerd Politics v.s. 數位治理"
          "資料、人工智慧與社群協作"
          "草根、開放、多中心的公民社群如何回應政治與科技的極權"
          "基於同理心、涵容、多元性的數位基礎建設"
          "技術與議題的交鋒"
        ]

  "keywords":
    meta:
      title: "請選擇與你投稿內容相關連之 g0v Summit 2024 之關鍵字"
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
      is-required: true
      config:
        note: ["可以參考本段落上方之說明"]

  "email":
    meta:
      title: "您的電子郵件"
      is-required: true
      term: [ {opset: \string, enabled: true, op: \email, msg: "格式不符", config: {}} ]
      config:
        note: ["電子郵件將作為聯繫投稿者的唯一方式"]

  "affiliation":
    meta:
      title: "您的服務單位與職稱"
      is-required: true
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
      config:
        note: ["將作為我們講者介紹的資訊"]

  "realname":
    meta:
      title: "您的姓名"
      is-required: true
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
      config:
        note: ["除非您願意被本名稱呼，否則我們並不會公開，僅將其作為聯繫與確認之用"]
  
  "name":
    meta:
      title: "我們應該如何稱呼您"
      is-required: true
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
      config:
        note: ["我們將以此回覆作為講者資訊的內容，若習慣以本名稱呼則填入本名即可"]
  
  "social_link":
    meta:
      title: "是否有服務單位 / 組織 / 社群的相關連結或社群帳號希望提供"
      is-required: true
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 500}]
      config:
        note: ["本題回覆內容會放在講者資訊中"]
        as-link: true

  "time_attend":
    type: \@makeform/checkbox
    meta:
      title: "可參加時間"
      is-required: true
      config:
        values: [
          "5/4（週六） 上午"
          "5/4（週六） 下午"
          "5/5（週日） 上午"
          "5/5（週日） 下午"
        ]

  "language":
    type: \@makeform/radio
    meta:
      title: "議程使用語言"
      is-required: true
      config:
        values: [
          "華語"
          "英語"
        ]
        other:
          enabled: true

  "visa_assistance":
    type: \@makeform/radio
    meta:
      title: "是否需要協助簽證"
      is-required: true
      config:
        values: [
          "是"
          "否"
        ]

  "diverse_traits":
    meta:
      title: "請簡述您所具有之多元特質"
      is-required: true
      config:
        note: ["包括但不限於性別、年齡、種族、職業、居住區域，足以讓 g0v Summit 呈現更多元的觀點，促進平等與共融。若無則填寫無即可"]
  
  "event_format":
    type: \@makeform/choice
    meta:
      title: "活動形式"
      is-required: true
      config:
        values: [
          "演講"
          "主題論壇"
          "工作坊"
        ]
      plugin: [
        * type: \dependency
          config:
            values: <[演講 工作坊 主題論壇]>
            is-required: true
            visible: true
            targets: <[participate_format]>
        * type: \dependency
          config:
            values: <[演講 工作坊]>
            is-required: true
            visible: true
            targets: <[speach_speaker]>
        * type: \dependency
          config:
            values: <[主題論壇]>
            is-required: true
            visible: true
            targets: <[
              sect-panel
              panel_speaker_1 panel_speaker_1_affilation
              panel_speaker_2 panel_speaker_2_affilation
              panel_speaker_3 panel_speaker_3_affilation
            ]>
        * type: \dependency
          config:
            values: <[工作坊]>
            is-required: true
            visible: true
            targets: <[
              sect-workshop
              workshop_length
              workshop_intro
              workshop_suitable
              workshop_equipment
            ]>
      ]

  "participate_format":
    type: \@makeform/choice
    meta:
      title: "參加形式"
      is-required: true
      config:
        values: [
          "現場參與"
          "線上參與"
          "預錄影片"
        ]

  "speach_speaker":
    type: \@makeform/radio
    meta:
      title: "講者名稱"
      is-required: false
      config:
        values: [
          "同投稿者"
        ]
        other:
          enabled: true

  "panel_speaker_1":
    meta:
      title: "講者1稱呼"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "panel_speaker_1_affilation":
    meta:
      title: "講者1服務單位與職稱"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "panel_speaker_2":
    meta:
      title: "講者2稱呼"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "panel_speaker_2_affilation":
    meta:
      title: "講者2服務單位與職稱"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "panel_speaker_3":
    meta:
      title: "講者3稱呼"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "panel_speaker_3_affilation":
    meta:
      title: "講者3服務單位與職稱"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "panel_note":
    meta:
      title: "備註"
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
      config:
        note: ["如果有超過三位講者，請將其他講者的稱呼、服務單位與職稱填入本欄位"]

  "workshop_length":
    type: \@makeform/choice
    meta:
      title: "請告知工作坊的時長"
      is-required: false
      config:
        values: [
          "30 分鐘"
          "60 分鐘"
          "90 分鐘"
        ]
  
  "workshop_intro":
    type: \@makeform/textarea
    meta:
      title: "請簡述這個工作坊的活動流程"
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 500, method: \simple-word}]
      is-required: false
      config:
        show-markdown-option: true
        limitation: \上限500字

  "workshop_suitable":
    meta:
      title: "請告知工作坊的適合人數區間"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]

  "workshop_equipment":
    meta:
      title: "請告知會需要主辦單位準備之器材"
      is-required: false
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
      config:
        note: ["目前根據場地，我們會為每個工作坊的議程準備投影機、螢幕、麥克風，其餘器材不保證能夠提供，建議自備"]

  "where_get":
    type: \@makeform/checkbox
    meta:
      title: "您是從哪裡得到 g0v Summit 2024 相關資訊的"
      is-required: true
      config:
        values: [
          "Facebook"
          "X (twitter)"
          "Instagram"
          "g0v.social"
          "其他社群夥伴或專案"
          "g0v slack"
          "g0v 官網"
          "親友告知"
          "其他網路資源"
        ]
        other:
          enabled: true

  "something_to_say":
    type: \@makeform/textarea
    meta:
      title: "其他想對 g0v Summit 2024 說的話"
