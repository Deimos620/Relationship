class Fixnum
  def get_digit_length
    Math.log10(self).to_i + 1
  end
end

class RelationshipsController < ApplicationController
  RELATIONSHIP_YEAR_DIGIT_LENGTH = 4

  def create
    @relationship = Relationship.new(permit_params)
    first_title = Title.find(params[:relationship][:influence_id])
    second_title = Title.find(params[:relationship][:influenced_id])

    if first_title.id == second_title.id
      flash[:alert] = "Can't select relationship. Same Title: #{@relationship.name}"
      redirect_to new_relationship_url and return
    end

    if first_title.year && first_title.year != 0 && first_title.year.get_digit_length == RELATIONSHIP_YEAR_DIGIT_LENGTH
      if second_title.year && second_title.year != 0 && second_title.year.get_digit_length == RELATIONSHIP_YEAR_DIGIT_LENGTH
         @relationship.influence_id = (first_title.year < second_title.year)? first_title.id : second_title.id
         @relationship.influenced_id = (first_title.year >= second_title.year)? first_title.id : second_title.id
      else
         @relationship.influence_id = first_title.id
         @relationship.influenced_id = second_title.id
      end
    else
      if second_title.year && second_title.year !=0 && second_title.year.get_digit_length == RELATIONSHIP_YEAR_DIGIT_LENGTH
        @relationship.influence_id = second_title.id
        @relationship.influenced_id = first_title.id
      else
        flash[:alert] = "Can't create relationship. Wrong year value."
        redirect_to new_relationship_url and return
      end
    end

    if @relationship.save
      redirect_to @relationship
    else
      render action: new_relationship
    end
  end

  def new
    @titles = {}
    @relationship = Relationship.new
    titles = Title.all
    titles.each do |title|
      @titles[title.name] = title.id
    end
  end

  def show
    @relationship = Relationship.find(params[:id])
    @first_title = Title.find(@relationship.influence_id)
    @second_title = Title.find(@relationship.influenced_id)
  end

  def destroy

  end

  def index
    @relationships = Relationship.all
  end

  private
  def permit_params
    params.require(:relationship).permit(:name, :relationship_type, :description)
  end
end
