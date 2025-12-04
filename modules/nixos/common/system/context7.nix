{config, ...}: {
  age.secrets.context7-api-key = {
    file = ../../../../secrets/context7-api-key.age;
    owner = "aster";
    group = "users";
    mode = "400";
  };

  environment.sessionVariables = {
    CONTEXT7_API_KEY = "$(cat ${config.age.secrets.context7-api-key.path})";
  };
}
