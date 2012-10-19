class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    if params[:ratings].nil?
      if flash[:ratings].nil?
        @ratings = @all_ratings
      else
        @ratings = flash[:ratings]
        flash[:ratings] = @ratings
      end
    else
    @ratings = params[:ratings].keys
    flash[:ratings] = @ratings
    end
    @sort = params[:sort]
    if @sort.nil?
    @sort = flash[:sort]
    end
    flash[:sort] = @sort
    @movies = Movie.order(@sort).where(:rating => @ratings)
#@movies = Movie.all(:order => @sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
