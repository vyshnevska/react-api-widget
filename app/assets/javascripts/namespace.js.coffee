unless root?
  root = exports ? this

# app namespace
unless root.Main
  root.Main = {}