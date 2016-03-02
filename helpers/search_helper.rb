module SearchHelper

  Figaro.application = Figaro::Application.new( {
    environment: "development",
    path:"./config/application.yml"} )
  Figaro.load

  def search(search_string)
    key = Figaro.env.search_api
    cx = Figaro.env.cx

    results = HTTParty.get( "https://www.googleapis.com/customsearch/v1?key=#{ key }&cx=#{ cx }&q=#{ search_string }" )

    results
  end

  def build_search_string
    humanoid = !!params[:humanoid]
    fun = !!params[:fun]
    helpful = !!params[:helpful]
    educational = !!params[:educational]
    vacuuming = !!params[:vacuuming]
    mowing = !!params[:mowing]
    scrubbing = !!params[:scrubbing]
    pictures = !!params[:pictures]
    surveillance = !!params[:surveillance]
    entertainment = !!params[:entertainment]
    other = params[:other]

    terms = ["robot"]

    if humanoid
      add_term(terms,"humanoid")
      add_term(terms,"biped")
    end

    if helpful
      add_term(terms,"helper")
      add_term(terms,"useful")
    end

    if fun
      add_term(terms,"toy")
      add_term(terms,"game")
      add_term(terms,"drone")
    end

    if educational
      add_term(terms,"kit")
      add_term(terms,"school")
      add_term(terms,"learning")
      add_term(terms,"robotics")
      add_term(terms,"educational")
    end

    if vacuuming
      add_term(terms,"vacuum")
      add_term(terms,"roomba")
      add_term(terms,"floor")
    end

    if scrubbing
      add_term(terms,"scrub")
      add_term(terms,"floor")
      add_term(terms,"hardwood")
      add_term(terms,"mop")
    end

    if mowing
      add_term(terms,"mower")
      add_term(terms,"lawnmower")
      add_term(terms,"lawn")
    end

    if pictures
      add_term(terms,"photography")
      add_term(terms,"camera")
      add_term(terms,"photo")
      add_term(terms,"pictures")
      add_term(terms,"drone")
    end

    if surveillance
      add_term(terms,"surveillance")
      add_term(terms,"camera")
      add_term(terms,"alarm")
      add_term(terms,"drone")
    end

    if entertainment
      add_term(terms,"entertainment")
      add_term(terms,"sing")
      add_term(terms,"dance")
    end

    add_term(terms,other)
    terms -= ['']
    terms.join("+").strip
  end

  def add_term(terms, term)
    terms << term
    terms << "OR"
  end
end
