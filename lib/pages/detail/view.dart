import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/components/book_cover.dart';
import 'package:voidlord/components/loading_block.dart';
import 'package:voidlord/model/book_info.dart';
import 'package:voidlord/pages/detail/componets/detail_about.dart';
import 'package:voidlord/pages/detail/componets/detail_action.dart';
import 'package:voidlord/pages/detail/componets/detail_btn.dart';
import 'package:voidlord/pages/detail/componets/detail_chapter.dart';
import 'package:voidlord/pages/detail/componets/detail_head.dart';
import 'package:voidlord/pages/detail/componets/detail_series.dart';
import 'package:voidlord/pages/detail/componets/detail_statistics.dart';
import 'package:voidlord/pages/detail/controller.dart';
import 'package:voidlord/utils/type.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bookDetailController = Get.find<BookDetailController>();
    var bookInfoModel = Get.arguments as BookInfoModel;
    return Scaffold(
        appBar: AppBar(
          title: Text(bookInfoModel.title),
          actions: [
            DetailAction(
              controller: bookDetailController,
              onTap: () {},
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  BookCover(id: bookInfoModel.id, url: bookInfoModel.coverUrl),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(child: _buildHead(bookDetailController)),
                ]),
                SizedBox(height: 20),
                _buildStatistics(bookDetailController),
                SizedBox(height: 20),
                _buildBtn(bookDetailController),
                SizedBox(height: 20),
                _buildAbout(bookDetailController),
                SizedBox(height: 20),
                _buildChapter(bookDetailController),
                SizedBox(height: 20),
                _buildSeries(bookDetailController),
                SizedBox(height: 80),
              ],
            ),
          ),
        ));
  }

  Widget _buildHead(BookDetailController controller) {
    return Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: switch (controller.loadingState.value) {
          LoadingState.loading =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              LoadingBlock(
                height: 30,
              ),
              SizedBox(height: 10),
              LoadingBlock(
                height: 30,
              ),
              SizedBox(height: 10),
              LoadingBlock(
                height: 30,
              ),
              SizedBox(height: 10),
              LoadingBlock(
                height: 30,
              ),
            ]),
          LoadingState.success =>
            DetailHead(bookDetailHead: controller.bookDetailModel.head!),
          LoadingState.failed => Container(),
        }));
  }

  Widget _buildStatistics(BookDetailController controller) {
    return Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: switch (controller.loadingState.value) {
          LoadingState.loading => LoadingBlock(
              height: 60,
            ),
          LoadingState.success => controller.bookDetailModel.statistics == null
              ? Container()
              : DetailStatistics(
                  bookDetailStatistics: controller.bookDetailModel.statistics!,
                ),
          LoadingState.failed => Container(),
        }));
  }

  Widget _buildBtn(BookDetailController controller) {
    return Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: switch (controller.loadingState.value) {
          LoadingState.loading => LoadingBlock(
              height: 60,
            ),
          LoadingState.success => DetailBtn(),
          LoadingState.failed => Container(),
        }));
  }

  Widget _buildAbout(BookDetailController controller) {
    return Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: switch (controller.loadingState.value) {
          LoadingState.loading => LoadingBlock(
              height: 60,
            ),
          LoadingState.success => controller.bookDetailModel.about == null
              ? Container()
              : DetailAbout(
                  bookDetailAbout: controller.bookDetailModel.about!,
                ),
          LoadingState.failed => Container(),
        }));
  }

  Widget _buildChapter(BookDetailController controller) {
    return Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: switch (controller.loadingState.value) {
          LoadingState.loading => LoadingBlock(height: 60),
          LoadingState.success => controller.bookDetailModel.chapter == null
              ? Container()
              : DetailChapter(
                  bookDetailChapter: controller.bookDetailModel.chapter!,
                ),
          LoadingState.failed => Container(),
        }));
  }

  Widget _buildSeries(BookDetailController controller) {
    return Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: switch (controller.loadingState.value) {
          LoadingState.loading => LoadingBlock(
              height: 60,
            ),
          LoadingState.success => controller.bookDetailModel.series == null
              ? Container()
              : DetailSeries(
                  bookDetailSeries: controller.bookDetailModel.series!,
                ),
          LoadingState.failed => Container(),
        }));
  }
}
