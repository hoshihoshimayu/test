class AnimesController < ApplicationController
  def index
    @animes = Anime.all
    @anime = Anime.new
    @like_ranks = Anime.find(Like.group(:anime_id).order('count(anime_id) desc').limit(3).pluck(:anime_id))
    @bad_ranks = Anime.find(Bad.group(:anime_id).order('count(anime_id) desc').limit(3).pluck(:anime_id))
  end

  def new
    @anime = Anime.new
  end

  def create
    #default_scope -> { order(created_at: :asc) }
    @anime = Anime.all.order(created_at: :asc)
    user_id = User.find_by(uid: session[:login_uid]).id
    @anime = Anime.new(message: params[:anime][:message],title: params[:anime][:title], user_id: user_id)
    #params.require(:user).permit(:image)
    if @anime.save
      redirect_to animes_path
    else
      redirect_to animes_path
     #render new_anime_path
    end
  end
  
  def edit
    @anime = Anime.find(params[:id])
    #@user = User.new
    #render "new"
  end

  def update
     @anime = Anime.find(params[:id])
     @anime.update(message: params[:anime][:message],title: params[:anime][:title], user_id: user_id)
    if anime.save
      redirect_to animes_path
    else
       render 'edit'
       #render :edit
    end
  end
  
  def destroy
    anime = Anime.find(params[:id])
    anime.destroy
    redirect_to animes_path
  end
  
  private
    def user_params
      params.require(:user).permit(:content, :image)
    end

end
