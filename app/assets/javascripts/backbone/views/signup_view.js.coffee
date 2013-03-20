class Mandula.Views.SignupView extends Backbone.View
  
  el: '#content'
  
  initialize: ->
    this.template = _.template($('#signup').html())
  
  render: ->
    tmpl = this.template()
    $(this.el).html(tmpl)
  
  close: ->
    this.remove()
    this.unbind()
