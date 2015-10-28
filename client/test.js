Template.body.helpers({
  emp: function() {
    return EMP.find({}, {limit: 100});
  }
});