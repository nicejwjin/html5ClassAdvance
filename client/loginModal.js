Template.loginModal.events({
  'click #btnLogin': function(evt, tmpl) {
    var username = $('#username').val();
    var password = $('#password').val();
    Meteor.loginWithPassword(username, password, function(error) {
      if(error) {
        alert(error);
      }
      else {
        $('#loginModal').modal('hide');
      }
    });
  },
  'click #btnJoin': function(evt, tmpl) {
    var username = $('#username').val();
    var password = $('#password').val();
    if(confirm('위 내용으로 가입을 하시겠습니까?')) {
      Meteor.call('addUser', username, password, function(err, rslt){
        if(err) {
          alert(err);
        }
        else {
          $('#loginModal').modal('hide');
        }
      });
    }
  }
})