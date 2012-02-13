# = Class: passenger::setup
#
# Description of passenger::setup
#
# == Parameters:
#
# $param::   Description of parameter
#
# == Actions:
#
# == Requires:
#
# == Sample Usage:
#
class passenger::setup {
  ## Copy paste snippets:
  # template("${module_name}/template.erb")
  # source => "puppet:///modules/${module_name}/file"

  require passenger::params
  require passenger::packages

  ## @todo: Put the passenger.conf in his place
  
}

