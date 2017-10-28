# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all.where(published: true)
  end

  def show
    @post = Post.find_by url: params[:path]
  end
end
