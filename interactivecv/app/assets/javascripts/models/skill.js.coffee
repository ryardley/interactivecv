Interactivecv.Skill = DS.Model.extend
  title: DS.attr('string')
  group: DS.attr('string')
  jobs: DS.hasMany('Interactivecv.Job')
