class Mandula.Views.SiteHeaderView extends Backbone.View
  
  el: '#header'
  
  initialize: ->
    this.template = _.template($('#siteHeader').html())
  
  render: ->
    console.log('render vom header view!')
    tmpl = this.template({currentUser: window.currentUser})
    $(this.el).html(tmpl)

  close: ->
    this.remove()
    this.unbind()
