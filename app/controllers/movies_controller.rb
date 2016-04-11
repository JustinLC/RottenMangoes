class MoviesController < ApplicationController
  
  def index
		@movies = Movie.page(params[:page]).per(2)
		
	  if params[:search_title] != ""
	    @movies = @movies.where("title LIKE ?", "%#{params[:search_title]}%")
	  end
	  if params[:search_director] != ""
	    @movies = @movies.where("director LIKE ?", "%#{params[:search_director]}%")
	  end
	  if params[:search_duration] != ""
	    case params[:search_duration]
		    when "Under 90 minutes"
		      @movies = @movies.where("runtime_in_minutes <= 90")
		    when "Between 90 and 120 minutes"
		      @movies = @movies.where("runtime_in_minutes BETWEEN 90 AND 120")
		    when "Over 120 minutes"
		      @movies = @movies.where("runtime_in_minutes >= 120")
	    end
	  end
	  @movies
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def new
		@movie = Movie.new
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			redirect_to movies_path(@movie)
		else
			render :edit
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path
	end

	protected

	def movie_params
   	params.require(:movie).permit(
    	:title, :release_date, :director, :runtime_in_minutes, :cover, :description
   	)
  end
end
