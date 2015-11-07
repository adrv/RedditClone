$ ->
  if window.gon.user
    PrivatePub.subscribe("/messages/new/#{window.gon.user.encrypted_id}", (data) ->
      $('body').prepend($("<a href = #{data.link}").html($('<div class="info">').html(data.msg)))
    )

  $('.vote').click () ->
    postId = $(this).parent().data('id')
    vote = $(this).data('vote')
    $.post("/posts/#{postId}/vote", {vote: vote}, (data) =>
      $(this).siblings('.votes_count').text(data.votes)
    )
    false

  $('.expand-reply').click ((e)->
    $(this).siblings(".simple_form.new_post").fadeIn();
    e.stopPropagation();
    false
  )
