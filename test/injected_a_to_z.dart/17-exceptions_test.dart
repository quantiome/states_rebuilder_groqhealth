import 'package:flutter_test/flutter_test.dart';
import 'package:states_rebuilder/src/reactive_model.dart';

void main() {
  StatesRebuilerLogger.isTestMode = true;
  testWidgets(
    'No Circular dependence even if the injected model is used in its creator',
    (tester) async {
      //Will not circle because the default null state is inferred
      expect(x.state, 0);
      dynamic err;
      try {
        //throw because null state is not defined
        arrayWithoutNullState.state;
      } catch (e) {
        err = e;
      }
      expect(err, isA<ArgumentError>());

      //Will not circle because the default null state is defined
      expect(arrayWithNullState.state, []);
    },
  );
  testWidgets(
    'No Circular dependence even if y is called in the creator of z '
    'and z  called in the creator of y',
    (tester) async {
      //will not throw
      expect(y1.state, 0);
      expect(y2.state, 0);
    },
  );

  // testWidgets(
  //   'Circular dependence z1 depends on z2 and z2 depends on z1',
  //   (tester) async {
  //     //will not throw
  //     expect(()=>z1, throws);
  //     expect(z1.state, 0);
  //   },
  // );
}

final ReactiveModel<int> x = RM.inject<int>(() => x.state);
final ReactiveModel<List> arrayWithoutNullState = RM.inject<List>(() => arrayWithoutNullState.state);
final ReactiveModel<List> arrayWithNullState = RM.inject<List>(() => arrayWithNullState.state, initialState: []);
//
final ReactiveModel<int> y1 = RM.inject<int>(() => y2.state);
final ReactiveModel<int> y2 = RM.inject<int>(() => y1.state);

//
//
// final ReactiveModel<int> z1 = RM.inject<int>(
//   () => z2.state,
//   dependsOn: DependsOn({z2}),
// );
// final ReactiveModel<int> z2 = RM.inject<int>(
//   () => z1.state,
//   dependsOn: DependsOn({z1}),
// );
