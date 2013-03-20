class Mandula.Views.HomeView extends Backbone.View
  
  el: '#content'
  
  initialize: ->
    this.template = _.template($('#home').html())

  render: ->
    
    videos = new Mandula.Models.VideoCollection()
    videos.fetch({
      success: =>
        tmpl = this.template({});
        $(this.el).html(tmpl);
        
        console.log videos
        @tile_container = $('#list-videos')
        _.each(videos.models, (video) =>
          console.log video
          this.renderVideo(video)
        )
        
      error: =>
        console.log "Oh oh!"
        # Todo: Weiterleiten oder rendern 404
    })

    console.log "Da issa!"

  renderVideo: (video) ->
      template = _.template($('#videoTile').html())
      @tile_container.append(template(video.toJSON()))

  close: ->
    this.remove()
    this.unbind()
