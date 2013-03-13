class Mandula.Views.ShowVideoView extends Backbone.View
  
  el: '#content'
  
  render: (id) ->
    video = new Mandula.Models.Video({id: id})
    video.fetch({
      success: =>
        console.log video
        console.log video.toJSON()
        template = _.template($('#videoShow').html())
        this.$el.html(template(video.toJSON()))
      error: =>
        console.log "Oh oh!"
        # Todo: Weiterleiten oder rendern 404
    })

  close: ->
    this.remove();
    this.unbind();
