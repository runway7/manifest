# frozen_string_literal: true

Rails.application.routes.draw do
  get '*path', to: 'posts#show'
  root 'posts#index'
end
