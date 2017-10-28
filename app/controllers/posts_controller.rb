# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all.where(published: true)
    @tags = []
  end

  def show
    @post = Post.find_by url: params[:path]
    return if @post.present?
    @posts = Post.all.where("tags @> ARRAY[?]::varchar[]", [params[:path]])
    if @posts.count > 0
      @tags = [params[:path]]
      render :index
      return
    end
    redirect_to root_path
  end
end
