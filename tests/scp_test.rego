
package aisi.scp

deny[msg] {
  input.Statement[_].Sid == "DenyDisableDeleteCloudTrail"
  not input.Statement[_].Action
  msg := "SCP must specify actions to deny"
}

require_region_restriction {
  some i
  input.Statement[i].Sid == "DenyUnsupportedRegions"
}
