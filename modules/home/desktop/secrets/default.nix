# {
#   inputs,
#   config,
#   ...
# }: let
#   inherit (config.age) secrets;
# in {
#   imports = [
#     inputs.agenix.homeManagerModules.age
#   ];
#   # there are no secrets for now.
# }
{}
