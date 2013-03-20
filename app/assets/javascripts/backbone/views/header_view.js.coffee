class Mandula.Views.SiteHeaderView extends Backbone.View
  
  el: '#header'
  
  events: {
    "mouseenter #logout div":  "showLogout",
    "mouseleave #logout div": "hideLogout"
  }

  initialize: ->
    this.template = _.template($('#siteHeader').html())
  
  render: ->
    console.log('render vom header view!')
    tmpl = this.template({currentUser: window.currentUser})
    $(this.el).html(tmpl)

  close: ->
    this.remove()
    this.unbind()

  showLogout: (e) ->
    $('#logout div').animate({'margin-top':'-46px'}, 150);

  hideLogout: (e) ->
    $('#logout div').animate({'margin-top':'0px'}, 75);
