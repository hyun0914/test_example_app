import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

// 참고 사이트
// https://velog.io/@nicesawo/FlutterPackage-snappingsheet-%ED%95%98%EB%8B%A8%EC%83%81%EB%8B%A8-%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C-sheet-%EB%A7%8C%EB%93%A4%EA%B8%B0

SnappingSheetController snappingSheetController = SnappingSheetController();

class TabBarSecondView extends StatelessWidget {
  const TabBarSecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      controller: snappingSheetController,
      // true: 최대, 최소에 보다 밑으로 위로 바텀시트가 움직이는걸 방지
      lockOverflowDrag: false,
      grabbingHeight: 68,
      grabbing: onHeader(),
      onSnapCompleted: (positionData, snappingPosition) {
        if(snappingPosition.grabbingContentOffset == 1.0) {
          print('닫힘');
        }
        else {
          print('열림');
        }
      },
      sheetBelow: SnappingSheetContent(
        draggable: true,
        child: onContent(),
      ),
      snappingPositions: [
        // 순서를 바꾸면 펼쳐져 있는 상태 이다.
        closeBottomSheetEvent,
        openBottomSheetEvent,
      ],
      child: Container(
        color: Colors.lightGreen,
      ),
    );
  }
}

Widget onHeader() {
  return Container(
    color: Colors.green,
    child: GestureDetector(
      onTap: () {
        snappingSheetController.snapToPosition(openBottomSheetEvent);
      },
      child: const Center(child: Text('열기')),
    ),
  );
}

Widget onContent() {
  return Container(
    color: Colors.greenAccent,
    child: const Center(child: Text('내용')),
  );
}

// 클릭시 최대로, 최소로 하기 (애니메이션효과없음)
// snappingSheetController.setSnappingSheetFactor(0.0);
// snappingSheetController.setSnappingSheetFactor(1.0);

dynamic closeBottomSheetEvent = const SnappingPosition.factor(
  positionFactor: 0.0,
  snappingCurve: Curves.easeOutSine,
  snappingDuration: Duration(seconds: 1),
  grabbingContentOffset: GrabbingContentOffset.top,
);

dynamic openBottomSheetEvent = const SnappingPosition.factor(
  positionFactor: 1.0,
  snappingCurve: Curves.easeOutSine,
  snappingDuration: Duration(seconds: 1),
  grabbingContentOffset: GrabbingContentOffset.bottom,
);