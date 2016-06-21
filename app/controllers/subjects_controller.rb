class SubjectsController < ApplicationController
  layout "admin"

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new(:name => "Default")
    @subject_count = Subject.count + 1

  end

  def create
    # Instantiate new object using params
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save is done, redirect to index
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay form with params
      @subject_count = Subject.count + 1
      render('new')
    end
  end


  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    # Find existing object using params
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
      # If update is done, redirect to index
      flash[:notice] = "Subject updated successfully"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # If update fails, redisplay form with params
      @subject_count = Subject.count
      render('edit')
    end
  end


  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully"
    redirect_to(:action => 'index')
  end


  # Private method for the params.
  private
    # same as params[:subject], except the only data that can be mass assigned is listed.
    def subject_params
      params.require(:subject).permit(:name, :position, :visible, :created_at)
    end

end
