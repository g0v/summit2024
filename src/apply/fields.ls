fields = {} <<<

  "title_zh":
    meta: 
      title: \議程標題
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 20, method: \simple-word}]
      config:
        variant: \zh
        limitation: \上限20字
  "title_en":
    meta:
      title: \議程標題
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 20, method: \simple-word}]
      config:
        variant: \en
        limitation: \上限20字

  "description_zh":
    type: \@makeform/textarea
    meta:
      title: \議程簡介
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 500, method: \simple-word}]
      config:
        variant: \zh
        show-markdown-option: true
        limitation: \上限500字

  "description_en":
    type: \@makeform/textarea
    meta:
      title: \議程簡介
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 500, method: \simple-word}]
      config:
        variant: \en
        show-markdown-option: true
        limitation: \上限500字

  "speaker":
    meta:
      title: "講者名稱"
      term: [{opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 100}]
