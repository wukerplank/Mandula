class Mandula.Views.MyVideosView extends Backbone.View
  
  el: '#content'
  
  initialize: ->
    this.template = _.template($('#myVideos').html())

  render: ->
    
    videos = new Mandula.Collections.MyVideoCollection()
    videos.fetch({
      success: =>
        console.log videos

        tmpl = this.template({});
        $(this.el).html(tmpl);


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
