//app.js
App({
  onLaunch: function () {
    // 展示本地存储能力
    var logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)

    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
        console.log(res);
        if (res.code) {
          wx.request({
            url: 'http://localhost/wechat/user/login',
            data: {
              code: res.code
            },
            success: function (res) {
              console.log(res);
              if (res.statusCode == 200) {
                wx.setStorageSync('init', '成功获取userToken！');
              } else {
                wx.setStorageSync('init', '获取userToken失败！');
              }
            },
            fail: function (e) {
              util.alert('数据请求失败！');
            }
          })
        } else {
          console.log('获取用户登录态失败！' + res.errMsg)
          // wx.setStorageSync('init', '获取用户登录态失败！');
        }
      }
    })
    // 获取用户信息
    wx.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
          wx.getUserInfo({
            success: res => {
              // 可以将 res 发送给后台解码出 unionId
              this.globalData.userInfo = res.userInfo

              // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
              // 所以此处加入 callback 以防止这种情况
              if (this.userInfoReadyCallback) {
                this.userInfoReadyCallback(res)
              }
            }
          })
        }
      }
    })
  },
  globalData: {
    userInfo: null
  },
  getInfo: function () {
    console.log(12);
  }
})