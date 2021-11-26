import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class BuildListItem extends StatelessWidget {
  final List selectDate;

  const BuildListItem({Key key, this.selectDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(selectDate.length);
    return Expanded(
      child: ListView.builder(
          itemCount: selectDate.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 1.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        selectDate[index]['isListSalary'] == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(selectDate[index]['Title'].toString()),
                                  Text(selectDate[index]['Money'].toString()),
                                ],
                              )
                            : selectDate[index]['isOvertime'] == true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(selectDate[index]['Content']
                                          .toString()),
                                      Text(selectDate[index]['OvertimeHour']
                                              .toString() +
                                          ' giờ'),
                                    ],
                                  )
                                : selectDate[index]['isBusinessTrip'] == true
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                200,
                                            child: Text(
                                              selectDate[index]['TrackingPlace']
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                          ),
                                          Text(selectDate[index]['FromTime']
                                              .toString()),
                                        ],
                                      )
                                    : selectDate[index]['isOnLeave'] == true
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(selectDate[index]['Content']
                                                  .toString()),
                                              Text(selectDate[index]['FromTime']
                                                  .toString()),
                                            ],
                                          )
                                        : Text(''),
                        selectDate[index]['isListSalary'] == true
                            ? selectDate[index]['isDone'] == '1'
                                ? Center(
                                    child: Text(
                                    'Chờ phê duyệt',
                                    style: TextStyle(
                                      color: getColorFromHex("#F9C130"),
                                    ),
                                  ))
                                : selectDate[index]['isDone'] == '2'
                                    ? Center(
                                        child: Text(
                                        'Đã duyệt',
                                        style: TextStyle(
                                          color: Colors.lightGreen,
                                        ),
                                      ))
                                    : selectDate[index]['isDone'] == '3'
                                        ? Center(
                                            child: Text(
                                            'Từ chối',
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          ))
                                        : null
                            : selectDate[index]['isOvertime'] == true
                                ? selectDate[index]['isDone'] == '1'
                                    ? Center(
                                        child: Text(
                                        'Chờ phê duyệt',
                                        style: TextStyle(
                                          color: getColorFromHex("#F9C130"),
                                        ),
                                      ))
                                    : selectDate[index]['isDone'] == '2'
                                        ? Center(
                                            child: Text(
                                            'Đã duyệt',
                                            style: TextStyle(
                                              color: Colors.lightGreen,
                                            ),
                                          ))
                                        : selectDate[index]['isDone'] == '3'
                                            ? Center(
                                                child: Text(
                                                'Từ chối',
                                                style: TextStyle(
                                                  color: Colors.redAccent,
                                                ),
                                              ))
                                            : null
                                : selectDate[index]['isBusinessTrip'] == true
                                    ? selectDate[index]['isDone'] == '1'
                                        ? Center(
                                            child: Text(
                                            'Chờ phê duyệt',
                                            style: TextStyle(
                                              color: getColorFromHex("#F9C130"),
                                            ),
                                          ))
                                        : selectDate[index]['isDone'] == '2'
                                            ? Center(
                                                child: Text(
                                                'Đã duyệt',
                                                style: TextStyle(
                                                  color: Colors.lightGreen,
                                                ),
                                              ))
                                            : selectDate[index]['isDone'] == '3'
                                                ? Center(
                                                    child: Text(
                                                    'Từ chối',
                                                    style: TextStyle(
                                                      color: Colors.redAccent,
                                                    ),
                                                  ))
                                                : Center(
                                                    child: Text(
                                                    '',
                                                    style: TextStyle(
                                                      color: Colors.redAccent,
                                                    ),
                                                  ))
                                    : selectDate[index]['isOnLeave'] == true
                                        ? selectDate[index]['isDone'] == '1'
                                            ? Center(
                                                child: Text(
                                                'Chờ phê duyệt',
                                                style: TextStyle(
                                                  color: getColorFromHex("#F9C130"),
                                                ),
                                              ))
                                            : selectDate[index]['isDone'] == '2'
                                                ? Center(
                                                    child: Text(
                                                    'Đã duyệt',
                                                    style: TextStyle(
                                                      color: Colors.lightGreen,
                                                    ),
                                                  ))
                                                : selectDate[index]['isDone'] ==
                                                        '3'
                                                    ? Center(
                                                        child: Text(
                                                        'Từ chối',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                      ))
                                                    : null
                                        : selectDate[index]['isCheckinLate'] ==
                                                true
                                            ? Center(
                                                child: Text(
                                                'Đã duyệt',
                                                style: TextStyle(
                                                  color: Colors.lightGreen,
                                                ),
                                              ))
                                            : selectDate[index]['isDone'] == '3'
                                                ? Center(
                                                    child: Text(
                                                    'Từ chối',
                                                    style: TextStyle(
                                                      color: Colors.redAccent,
                                                    ),
                                                  ))
                                                : selectDate[index]
                                                            ['isCheckinLate'] ==
                                                        true
                                                    ? Center(
                                                        child: Text(
                                                        'Đã duyệt',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.lightGreen,
                                                        ),
                                                      ))
                                                    : selectDate[index]
                                                                ['isDone'] ==
                                                            '3'
                                                        ? Center(
                                                            child: Text(
                                                            'Từ chối',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                            ),
                                                          ))
                                                        : null,
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
