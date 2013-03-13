class Mandula.Views.NewVideoView extends Backbone.View
  
  el: '#content'
  
  initialize: ->
    this.template = _.template($('#videoNew').html());
  
  render: ->
    tmpl = this.template({});
    $(this.el).html(tmpl);

  close: ->
    this.remove();
    this.unbind();
