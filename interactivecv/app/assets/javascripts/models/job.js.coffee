Interactivecv.Job = DS.Model.extend
  title: DS.attr('string')
  company: DS.attr('string')
  location: DS.attr('string')
  description: DS.attr('string')
  startDate: DS.attr('date')
  endDate: DS.attr('date')
  skills: DS.hasMany('Interactivecv.Skill')
