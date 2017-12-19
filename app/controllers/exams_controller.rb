class ExamsController < ApplicationController

  require 'humanize'

  def index
    @exam = Exam.all
    @exam.sort! {|a,b| a.question <=> b.question}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  def show
    @exam = Exam.find_by(id: params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  def new
    @exam = Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  def edit
    @exam = Exam.find(params[:id])
  end

  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to(@exam, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @exam = Exam.find_by(id: params[:id])

    respond_to do |format|
      if @exam.update_attributes(exam_params)
        format.html { redirect_to(@exam, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @exam = Exam.find_by(id: params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to(exams_path) }
      format.xml  { head :ok }
    end
  end

  def take
    @exam = Exam.find_by(id: params[:id])
    # @hide = true
  end

  def submit_quiz
    @answer1 = params[:exam][:answer]
    @exam = Exam.find_by(id: params[:id])

    if is_number? (@answer1)
      @answer2 = @exam.answer.to_s
    else
      @answer2 = @exam.answer
    end
    @answer3 = @answer2.humanize

    respond_to do |format|
      if @answer1 == @answer2 || @answer1 == @answer3
        format.html { redirect_to(exams_take_path(@exam.id, val: true), :notice => "Answer by user on Quiz mode: #{@answer1} CORRECT") }
        format.xml  { head :ok }
      else
        format.html { redirect_to(exams_take_path(@exam.id, val: false), :notice => "Answer by user on Quiz mode: #{@answer1} INCORRECT") }
        format.xml  { head :ok }
      end
    end
  end

  def is_number? string
    true if Float(string) rescue false
  end

  private

  def exam_params
    params.require(:exam).permit(:answer, :question)
  end
end
