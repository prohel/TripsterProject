class UsersController < ApplicationController
	 before_filter :set_User, only: [:addFriend, :show, :edit, :update, :destroy]
   helper_method :recommend, :trendingdreamlocation

  # GET /Users
  # GET /Users.json
  def index
    @Users = current_user.friends
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
    @friendsOfFriends = recommend
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

  def trendingdreamlocation
    @dl = UserLocation.select('location_id').where("visited = ?", 0).group('location_id').order('count_location_id desc').count('location_id').take(5)
    # @dl = UserLocation.where("visited = ?", 0)
    # @ids = @dl.map {|i| i.location_id }
    @locs ||= []
    @dl.each do |key, val|
      @locs << Location.find(key)
      @count = val
    end
    @locs
    # @locs = Location.where("id in (?)", @ids)
      # tl = UserLocation.where("visited = ? AND location_id in (?) ", 0, @ids)
    # dream_locations = UserLocation.where("visited = ?", 0)
    # @trendy_locations = UserLocation.where("visited = ? AND location_id =", 0 and dream_locations.id) 
  end

  def bingsearch
    #Tripster searche for user and trips
    @userSearches = User.where("name like ?", "%#{params[:search]}%").order("created_at DESC")
    @tripSearches = Trip.where("name like ?", "%#{params[:search]}%").order("created_at DESC")
    @tripSearches.delete_if {|t| !t.isOneOfThemMember(current_user.friends)}
    #Bing Web Searches
    bing_web = Bing.new("ZQUcJ2qGUYKP7LhoWVqAnI9pLcJAy0oseXLO/8bYePo", 10, 'Web')
    @bing_results_web = bing_web.search(params[:search])

    #Bing Image Searches
    bing_image = Bing.new("ZQUcJ2qGUYKP7LhoWVqAnI9pLcJAy0oseXLO/8bYePo", 10, 'Image')
    @bing_results_images = bing_image.search(params[:search])

    
    #Bing Videos
    bing_video = Bing.new("ZQUcJ2qGUYKP7LhoWVqAnI9pLcJAy0oseXLO/8bYePo", 10, 'Video')
    @bing_results_videos = bing_video.search(params[:search])
  end

  def search
    @userSearches = User.where("name like ?", "%#{params[:search]}%").order("created_at DESC")
    @tripSearches = Trip.where("name like ?", "%#{params[:search]}%").order("created_at DESC")
  end

  def recommend
       
     friends = current_user.friends
     @friendsOfFriends = Hash.new
     friends.each do |f|
        f.friends.each do |f2|
          friendFlag = true
          friends.each do |f1| if (f2 == f1)
            friendFlag = false
          end
        end
          if !@friendsOfFriends.include?(f2) and !(f2 == current_user) and friendFlag
            a = @friendsOfFriends[f2.id]
            @friendsOfFriends[f2.id] = a.blank? ? 1 : a+1;
          end
        end
      end
      @friendsOfFriends.sort_by {|k, v| [v, k] }
      @friendsOfFriends.keys.take(5)
  end

  def friendslist
      @friends = Friendship.where("user1_id like ?", current_user.id)
  end

  def like
      if params[:likeable_type] == "Trip"
        @likeable = Trip.find(params[:likeable_id])
      elsif params[:likeable_type] == "Album"
        @likeable = Album.find(params[:likeable_id])
      elsif params[:likeable_type] == "Attachment"
        @likeable = Attachment.find(params[:likeable_id])
      end
  current_user.like!(@likeable)
  end

  def friendRequests
    @myRequests = Friendship.find_all_by_user1_id(current_user)
    @myRequests.delete_if {|x| x.isReciprocate}
    @myInvites = Friendship.find_all_by_user2_id(current_user)
    @myInvites.delete_if {|x| x.isReciprocate}
  end

  def unlike
      if params[:likeable_type] == "Trip"
          @likeable = Trip.find(params[:likeable_id])
      elsif params[:likeable_type] == "Album"
        @likeable = Album.find(params[:likeable_id])
      elsif params[:likeable_type] == "Attachment"
        @likeable = Attachment.find(params[:likeable_id])
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