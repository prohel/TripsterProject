class UsersController < ApplicationController
	 before_filter :set_User, only: [:addFriend, :show, :edit, :update, :destroy]
   helper_method :recommend

  # GET /Users
  # GET /Users.json
  def index
    @Users = User.all
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
  end

  def newsfeed
    @news = []
    friendsNotifications = []
    tripsCreations = []
    tripsInvites = []
    friends = current_user.friends
    userPlusFriends = Array.new(friends)
    userPlusFriends << current_user
    friends.each do |f|
      friendsNotifications += f.friendships
    end
    friendsNotifications.each do |notif|
      @news << {
        created_at: notif.created_at,
        type: "friend",
        owner_id: notif.user1.id,
        target_id: notif.user2.id
      }
    end
    userPlusFriends.each do |friend|
      friend.trips.each do |notif|
        @news << {
          created_at: notif.created_at,
          type: "trip",
          owner_id: notif.creator.id,
          target_id: notif.id
        }
      end
    end
    userPlusFriends.each do |person|
      tripsInvites += person.accepted_requests_and_invites
    end
      tripsInvites.uniq.each do |notif|
        trip = Trip.find(notif.trip_id)
        owner = trip.creator
        @news << {
          created_at: notif.updated_at,
          type: "invite",
          owner_id: notif.sender == owner ? notif.receiver.id : notif.sender.id,
          target_id: notif.trip_id
        }
      end
    userPlusFriends.each do |friend|
      friend.attachments.each do |notif|
        @news << {
          created_at: notif.created_at,
          type: "attachment",
          owner_id: notif.user.id,
          target_id: notif.id
        }
      end
    end
    @friendsOfFriends = friends.map {|f| f.friends}.flatten
      .delete_if {|f| friends.include?(f) || f == current_user}
    @news = @news.sort_by{|n| n[:created_at]}.reverse
  end

  def addFriend
  	@Friendship = Friendship.new({user1_id: current_user.id, user2_id: @User.id})
    if @Friendship.save
        render 'users/show', notice: 'Friendship request has been sent'
        #format.json { render :show, status: :created, location: @User }
    else
        render 'users/show', notice: 'There has been an error.' 
        #format.json { render json: @User.errors, status: :unprocessable_entity }
    end

  end

  # GET /Users/new
  def new
    @User = User.new
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
    @User = User.new(User_params)
    respond_to do |format|
      if @User.save
        format.html { redirect_to @User, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @User }
      else
        format.html { render :new }
        format.json { render json: @User.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @User.update(User_params)
        format.html { redirect_to @User, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @User }
      else
        format.html { render :edit }
        format.json { render json: @User.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @User.destroy
    respond_to do |format|
      format.html { redirect_to Users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @userSearches = User.where("name like ?", "%#{params[:search]}%").order("created_at DESC")
    @tripSearches = Trip.where("name like ?", "%#{params[:search]}%").order("created_at DESC")
  end

  def recommend
     @recommendList ||= []   
     friends = current_user.friends
     @friendsOfFriends = friends.map {|f| f.friends}.flatten
      .delete_if {|f| friends.include?(f) || f == current_user}
  end

  def friendslist
      @friends = Friendship.where("user1_id like ?", current_user.id)
  end

  def like
      if params[:likeable_type] == "Trip"
          @likeable = Trip.find(params[:likeable_id])
      end
  current_user.like!(@likeable)
  end

  def unlike
      if params[:likeable_type] == "Trip"
          @likeable = Trip.find(params[:likeable_id])
      end
  current_user.unlike!(@likeable)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_User
      @User = User.find(params[:id]) if params[:id]
      @User = current_user if !@User
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def User_params
      params.require(:User).permit(:name, :id, :start_date, :end_date)
    end
end