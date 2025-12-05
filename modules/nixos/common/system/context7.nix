{config, ...}: {
  age.secrets.context7-api-key = {
    file = ../../../../secrets/context7-api-key.age;
    owner = "aster";
    group = "users";
    mode = "400";
  };

  # $(cat ...) is expanded by the shell at session start, not at eval time
  environment.sessionVariables = {
    CONTEXT7_API_KEY = "$(cat ${config.age.secrets.context7-api-key.path})";
  };
}
