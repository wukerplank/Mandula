class Mandula.Views.HomeView extends Backbone.View
  
  el: '#content'
  
  initialize: ->
    

  render: ->
    
    videos = new Mandula.Models.VideoCollection()
    videos.fetch({
      success: =>
        console.log videos
        this.$el.html('')
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
      this.$el.append(template(video.toJSON()))

  close: ->
    this.remove();
    this.unbind();
