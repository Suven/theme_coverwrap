cut = (str, l) ->
	if Array.isArray(str)
		str = str.join(", ")
	if str.length - 3 > l
		return "#{str.substr(0, l - 3)}..."
	if str?
		""

shortDate = (d) ->
	d = new Date(d.substr(0,10))
	"#{d.getDate()}.#{d.getMonth() + 1}.#{d.getFullYear()}"

updateList = (skip) ->
	$('.cover').html ''
	$('.cover').append """<section class="el"></section>"""
	$('.cover').append """<section class="el"></section>"""
	$('.cover').append """<section class="el"></section>"""

	i = 0
	for mov in data

		if i is 0
			eclass = "mid" 
		else
			eclass = ""

		$('.cover').append """<section data-id="#{mov.movieid}" class="el pos-#{i++}"><img src="./poster.png" class="#{eclass}" data-original="./thumbs/#{mov.movieid}.jpg" /></section>"""

	$('.cover > .el > img').lazyload
	    container: $(".coverwrap")
	    threshold: 400

	updateDetails $(".cover .el.pos-0").data('id')

getMovie = (id) ->
	for mov in data
		return mov if mov.movieid is id

getWriterList = (mov) ->
	str = "<ul class='perslist'>"
	for pers in mov.writer
		str += "<li>#{pers}</li>"
	str += "</ul>"

getCastList = (mov) ->
	str = "<ul class='perslist'>"
	for pers in mov.cast
		str += "<li><strong>#{pers.name}</strong> as #{pers.role}</li>"
	str += "</ul>"

updateDetails = (id) ->
	mov = getMovie id
	if mov?
		$('.details .year').html mov.year
		$('.details .title').html mov.label
		$('.details .tagline').html mov.tagline
		$('.details .plot').html mov.plot
		$('.details .genre').html mov.genre.join(" / ")
		$('.details .cast').html getCastList mov
		$('.details .writer').html getWriterList mov
		$('.details .director').html mov.director.join(", ")
		$('.details .country').html mov.country
		$('.details .length').html "#{mov.runtime / 60} min"
		$('.details .rating').html "Rating: #{mov.rating.toPrecision(3)}"
		$('.details .id').html mov.movieid

	$('.marquee').marquee
		duration: 10000
		pauseOnHover: true

genericSort = (a, b) ->
	return 0 if a is b
	a > b ? 1 : -1

titleSort = (a, b) ->
	genericSort(a.label, b.label)

yearSort = (a, b) ->
	genericSort(a.year, b.year)

dateSort = (a, b) ->
	genericSort(a.dateadded, b.dateadded)

$ ->
	$('.cover').css(
		'width': "#{(data.length + 3) * 133}px"
	)

	$('.coverwrap').animate
		scrollLeft: 0
		500
		'linear'

	$('body').css( 
		height: window.innerHeight - 220
	)

	$('ul.sort li').click ->

		switch $(@).data('by')
			when 'title' then data.sort titleSort
			when 'year' then data.sort yearSort
			when 'added' then data.sort dateSort

		sort = $(@).data('dir')
		if $(@).data('by') is $('ul.sort li.active').first().data('by')
			sort = if sort is 'asc' then 'desc' else 'asc'

		if sort is 'desc'
			data.reverse()

		$('ul.sort li.active').removeClass 'active'
		$(@).addClass 'active'
		$(@).data('dir', sort)

		updateList()

	scrollTimer = 0
	initial = true
	$('.coverwrap').scroll (e) ->
		window.clearTimeout scrollTimer

		if initial
			$('.coverwrap .el > img.mid').removeClass 'mid'
			initial = false

		scrollTimer = window.setTimeout(
			->
				pos = Math.round($('.coverwrap').scrollLeft() / 120)
				newPos = pos * 120
				$(".coverwrap .el.pos-#{pos} > img").addClass 'mid'
				$('.coverwrap').animate(
					scrollLeft: newPos
					500
					'linear'
				)

				updateDetails $(".coverwrap .el.pos-#{pos}").data('id')

				initial = true
			250
		)

	updateList()
