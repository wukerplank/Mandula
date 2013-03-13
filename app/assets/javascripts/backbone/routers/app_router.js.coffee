class Mandula.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    console.log 'Hey da ist der Init. vom Router!'

  routes:
    '':           'home',
    'home':       'home'
    'videos/new': 'videoNew'
    'videos/:id': 'videoShow'

  home: ->
    console.log "You're at home baby!"
    view = new Mandula.Views.HomeView()
    view.render()
  
  videoNew: ->
    console.log "New Video? Give it to me!"
    view = new Mandula.Views.NewVideoView()
    view.render()

  videoShow: (id) ->
    console.log "Da hast das Video Nummer " + id
    
    view = new Mandula.Views.ShowVideoView()
    view.render(id)