define(['jquery', 'underscore'], function($, _) {
  return {
    API_BASE_URL: "https://leancloud.cn/1.1",
    APP_ID: "Cpt7lNSjHVOCP1DvYNT73ky9",
    APP_KEY: "AbTX5HRGkOry6rwBdG59lfkd",
    _makeReq: function(set) {
      var headers, rawHeaders, result;
      if (set == null) {
        set = {
          method: 'GET',
          headers: {}
        };
      }
      result = {};
      if (set.method !== "GET") {
        set.data = JSON.stringify(set.data);
      }
      rawHeaders = {
        "X-LC-Id": this.APP_ID,
        "X-LC-Key": this.APP_KEY
      };
      headers = _.extend(rawHeaders, set.headers);
      $.ajax({
        type: set.method,
        url: this.API_BASE_URL + "/" + set.url,
        params: set.params,
        data: set.data,
        contentType: "application/json",
        dataType: "json",
        async: false,
        success: function(data, _) {
          return result = data;
        },
        headers: headers
      });
      console.log(result);
      return result;
    },
    checkIfExist: function(mobile) {
      var data;
      console.log("FUCK!");
      data = this._makeReq({
        method: 'GET',
        url: 'classes/Attendances',
        data: {
          where: {
            mobile: mobile
          }
        }
      });
      console.log(data);
      if (data.results.length > 0) {
        return true;
      } else {
        return false;
      }
    },
    updateInfo: function(mobile, data) {
      var exist, objId, result;
      if (data == null) {
        data = {};
      }
      exist = this._makeReq({
        method: 'GET',
        url: 'classes/Attendances',
        data: {
          where: {
            mobile: mobile
          }
        }
      });
      if (exist.results.length > 0) {
        objId = exist.results[0].objectId;
        result = this._makeReq({
          method: "PUT",
          url: "classes/Attendances/" + objId,
          data: data
        });
        return result;
      } else {
        return false;
      }
    },
    SMSVerifySend: function(mobile) {
      return this._makeReq({
        method: "POST",
        url: "requestSmsCode",
        data: {
          mobilePhoneNumber: mobile
        }
      });
    },
    SMSVerifyCheck: function(mobile, code) {
      return this._makeReq({
        method: "POST",
        url: "verifySmsCode/" + code + "?mobilePhoneNumber=" + mobile
      });
    },
    createUserByMobile: function(mobile, code) {
      return this._makeReq({
        method: "POST",
        url: 'usersByMobilePhone',
        data: {
          mobilePhoneNumber: mobile,
          smsCode: code
        }
      });
    },
    getUserAttendanceDataByMobile: function(mobile) {
      var exist, objId, result;
      exist = this._makeReq({
        method: 'GET',
        url: 'classes/Attendances',
        data: {
          where: {
            mobile: mobile
          }
        }
      });
      if (exist.results.length > 0) {
        objId = exist.results[0].objectId;
        result = this._makeReq({
          method: "GET",
          url: "classes/Attendances/" + objId
        });
        return result;
      } else {
        return {};
      }
    },
    updateUserData: function(id, session, data) {
      return this._makeReq({
        method: 'PUT',
        url: "users/" + id,
        data: data,
        headers: {
          "X-LC-Session": session
        }
      });
    }
  };
});
