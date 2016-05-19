
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
	getTime()
	window.v = 1

source = new EventSource('/events')

source.onmessage = (event) ->
	if event.data != "thump"
		tweet = $.parseJSON(event.data)
		$("#tweet-container-"+window.v).html("#{tweet.embed}")
		setTimeout(reveal, 500)


reveal = () ->
	$("#tweet-container-"+window.v).css opacity: 100
	window.v++
	if window.v == 3
		window.v =1
	$("#tweet-container-"+window.v).css opacity: 0

getTime = ->
	today = new Date
	h = today.getHours()
	m = today.getMinutes()
	if h > 12
		h = h - 12
	if h == 0
		h = 12
	if m < 10 
		m = '0' + m

	document.getElementById('time').innerHTML = h + ':' + m

	t = setTimeout(getTime, 500)

	return