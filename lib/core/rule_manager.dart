import 'package:get/get.dart';
import 'package:simplane_client_admin/model/rule.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/repository/rule_repository.dart';

class RuleManager {
  static final RuleManager instance = RuleManager._internal();
  RuleManager._internal();

  Rule? _rule;

  Rule? get rule => _rule;

  Future<Rule?> load() async {
    RuleRepository ruleRepo = Get.find();
    _rule = await ruleRepo.getRule();
    return _rule;
  }

  Future<Rule?> updateRule(Rule rule) async {
    RuleRepository repo = Get.find();
    _rule = await repo.updateRule(rule);
    return _rule;
  }
}
