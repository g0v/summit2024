# g0v Summit 2024 CFP

## How to start

```
git checkout main
npm i
npm start
```

## How to deploy

網站透過 grantdash 拉取 release branch 來部屬，所以要在 grantdash 這個 branch 執行 build 和 deploy

```
git checkout grantdash
npm i
./build
./deploy
```

然後到 grantdash 主控台（需權限） `計畫設定→模板設定→部屬網站→點擊更新`

## TODO
- [ ] rebuild with nuxtjs
