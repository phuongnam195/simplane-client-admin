import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/rule.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

abstract class RuleRepository extends BaseRepository<Rule> {
  Future<Rule> getRule();

  Future<Rule> updateRule(Rule rule);
}

class RuleRepositoryImp extends BaseRepositoryImp<Rule>
    implements RuleRepository {
  @override
  Future<Rule> getRule() async {
    // return ruleDummy;

    return Rule.fromJson(await ApiClient(RULE).get());
  }

  @override
  Future<Rule> updateRule(Rule newRule) async {
    // ruleDummy = newRule;
    // return ruleDummy;

    return Rule.fromJson(await ApiClient(RULE).post(newRule.toJson()));
  }
}
