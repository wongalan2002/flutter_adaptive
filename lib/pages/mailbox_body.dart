import 'package:adaptive_app_demos/application_state.dart';
import 'package:adaptive_app_demos/models/quotation_item.dart';
import 'package:adaptive_app_demos/pages/quotation_item_preview_card.dart';
import 'package:adaptive_app_demos/pages/quotations_list_page.dart';
import 'package:adaptive_app_demos/pages/setting_page.dart';
import 'package:adaptive_app_demos/pages/start_page.dart';
import 'package:flutter/material.dart';
import '../adaptive.dart';
import 'package:provider/provider.dart';

class MailboxBody extends StatelessWidget {
  const MailboxBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isTablet = isDisplaySmallDesktop(context);
    final startPadding = isTablet
        ? 60.0
        : isDesktop
            ? 120.0
            : 4.0;
    final endPadding = isTablet
        ? 30.0
        : isDesktop
            ? 60.0
            : 4.0;

    return Consumer<ApplicationState>(
      builder: (context, appState, child) {
        final destination = appState.selectedMailboxPage;
        final destinationString = destination
            .toString()
            .substring(destination.toString().indexOf('.') + 1);
        List<QuotationItem> quotationItem;
        // List<Email> emails;

        // switch (destination) {
        //   case MailboxPageType.inbox:
        //     {
        //       emails = appState.inboxEmails;
        //       break;
        //     }
        //   case MailboxPageType.sent:
        //     {
        //       emails = appState.outboxEmails;
        //       break;
        //     }
        //   case MailboxPageType.starred:
        //     {
        //       emails = appState.starredEmails;
        //       break;
        //     }
        //   case MailboxPageType.trash:
        //     {
        //       emails = appState.trashEmails;
        //       break;
        //     }
        //   case MailboxPageType.spam:
        //     {
        //       emails = appState.spamEmails;
        //       break;
        //     }
        //   case MailboxPageType.drafts:
        //     {
        //       emails = appState.draftEmails;
        //       break;
        //     }
        // }
        if (destination == MailboxPageType.inbox) {
          // return Text("INBOX");
          return SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StartPage()
                  // child: appState.quotationOrder.quotationItems!.isEmpty
                  //     ? Center(child: Text('Empty in $destinationString'))
                  //     : ListView.separated(
                  //         itemCount:
                  //             appState.quotationOrder.quotationItems!.length,
                  //         padding: EdgeInsetsDirectional.only(
                  //           start: startPadding,
                  //           end: endPadding,
                  //           top: isDesktop ? 28 : 0,
                  //           bottom: kToolbarHeight,
                  //         ),
                  //         primary: false,
                  //         separatorBuilder: (context, index) =>
                  //             const SizedBox(height: 4),
                  //         itemBuilder: (context, index) {
                  //           var email =
                  //               appState.quotationOrder.quotationItems![index];
                  //           return Text("INBOX");
                  //           // return QuotationItemPreviewCard(
                  //           //     quotationItem: email,
                  //           //     onDelete: () =>
                  //           //         appState.deleteQuotationItem(index),
                  //           //     index: index,
                  //           //     callback: appState.updateQuotationItem);
                  //           // return MailPreviewCard(
                  //           //   id: email.id,
                  //           //   email: email,
                  //           //   isStarred: model.isEmailStarred(email.id),
                  //           //   onDelete: () => model.deleteEmail(email.id),
                  //           //   onStar: () => model.starEmail(email.id),
                  //           //   onStarredMailbox: model.selectedMailboxPage ==
                  //           //       MailboxPageType.starred,
                  //           // );
                  //         },
                  //       ),
                ),
                // if (isDesktop) ...[
                //   Padding(
                //     padding: const EdgeInsetsDirectional.only(top: 14),
                //     child: Row(
                //       children: [
                //         IconButton(
                //           key: const ValueKey('ReplySearch'),
                //           icon: const Icon(Icons.search),
                //           onPressed: () {
                //             // Provider.of<ApplicationState>(
                //             //   context,
                //             //   listen: false,
                //             // ).onSearchPage = true;
                //           },
                //         ),
                //         SizedBox(width: isTablet ? 30 : 60),
                //       ],
                //     ),
                //   ),
                // ]
              ],
            ),
          );
        }
        if (destination == MailboxPageType.starred) {
          // return Text("starred");
          return SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: QuotationsListPage()
                  // child: appState.quotationOrder.quotationItems!.isEmpty
                  //     ? Center(child: Text('Empty in $destinationString'))
                  //     : ListView.separated(
                  //   itemCount:
                  //   appState.quotationOrder.quotationItems!.length,
                  //   padding: EdgeInsetsDirectional.only(
                  //     start: startPadding,
                  //     end: endPadding,
                  //     top: isDesktop ? 28 : 0,
                  //     bottom: kToolbarHeight,
                  //   ),
                  //   primary: false,
                  //   separatorBuilder: (context, index) =>
                  //   const SizedBox(height: 4),
                  //   itemBuilder: (context, index) {
                  //     var email =
                  //     appState.quotationOrder.quotationItems![index];
                  //     return Text("STARTS");
                  //     // return QuotationItemPreviewCard(
                  //     //     quotationItem: email,
                  //     //     onDelete: () =>
                  //     //         appState.deleteQuotationItem(index),
                  //     //     index: index,
                  //     //     callback: appState.updateQuotationItem);
                  //     // return MailPreviewCard(
                  //     //   id: email.id,
                  //     //   email: email,
                  //     //   isStarred: model.isEmailStarred(email.id),
                  //     //   onDelete: () => model.deleteEmail(email.id),
                  //     //   onStar: () => model.starEmail(email.id),
                  //     //   onStarredMailbox: model.selectedMailboxPage ==
                  //     //       MailboxPageType.starred,
                  //     // );
                  //   },
                  // ),
                ),
                // if (isDesktop) ...[
                //   Padding(
                //     padding: const EdgeInsetsDirectional.only(top: 14),
                //     child: Row(
                //       children: [
                //         IconButton(
                //           key: const ValueKey('ReplySearch'),
                //           icon: const Icon(Icons.search),
                //           onPressed: () {
                //             // Provider.of<ApplicationState>(
                //             //   context,
                //             //   listen: false,
                //             // ).onSearchPage = true;
                //           },
                //         ),
                //         SizedBox(width: isTablet ? 30 : 60),
                //       ],
                //     ),
                //   ),
                // ]
              ],
            ),
          );
        }
        if (destination == MailboxPageType.sent) {
          // return Text("sent");
          return SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SettingPage()
                  // child: appState.quotationOrder.quotationItems!.isEmpty
                  //     ? Center(child: Text('Empty in $destinationString'))
                  //     : ListView.separated(
                  //   itemCount:
                  //   appState.quotationOrder.quotationItems!.length,
                  //   padding: EdgeInsetsDirectional.only(
                  //     start: startPadding,
                  //     end: endPadding,
                  //     top: isDesktop ? 28 : 0,
                  //     bottom: kToolbarHeight,
                  //   ),
                  //   primary: false,
                  //   separatorBuilder: (context, index) =>
                  //   const SizedBox(height: 4),
                  //   itemBuilder: (context, index) {
                  //     var email =
                  //     appState.quotationOrder.quotationItems![index];
                  //     return Text("STARTS");
                  //     // return QuotationItemPreviewCard(
                  //     //     quotationItem: email,
                  //     //     onDelete: () =>
                  //     //         appState.deleteQuotationItem(index),
                  //     //     index: index,
                  //     //     callback: appState.updateQuotationItem);
                  //     // return MailPreviewCard(
                  //     //   id: email.id,
                  //     //   email: email,
                  //     //   isStarred: model.isEmailStarred(email.id),
                  //     //   onDelete: () => model.deleteEmail(email.id),
                  //     //   onStar: () => model.starEmail(email.id),
                  //     //   onStarredMailbox: model.selectedMailboxPage ==
                  //     //       MailboxPageType.starred,
                  //     // );
                  //   },
                  // ),
                ),
                // if (isDesktop) ...[
                //   Padding(
                //     padding: const EdgeInsetsDirectional.only(top: 14),
                //     child: Row(
                //       children: [
                //         IconButton(
                //           key: const ValueKey('ReplySearch'),
                //           icon: const Icon(Icons.search),
                //           onPressed: () {
                //             // Provider.of<ApplicationState>(
                //             //   context,
                //             //   listen: false,
                //             // ).onSearchPage = true;
                //           },
                //         ),
                //         SizedBox(width: isTablet ? 30 : 60),
                //       ],
                //     ),
                //   ),
                // ]
              ],
            ),
          );
        }
        return SafeArea(
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: appState.quotationOrder.quotationItems!.isEmpty
                    ? Center(child: Text('Empty in $destinationString'))
                    : ListView.separated(
                        itemCount:
                            appState.quotationOrder.quotationItems!.length,
                        padding: EdgeInsetsDirectional.only(
                          start: startPadding,
                          end: endPadding,
                          top: isDesktop ? 28 : 0,
                          bottom: kToolbarHeight,
                        ),
                        primary: false,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          var email =
                              appState.quotationOrder.quotationItems![index];
                          return QuotationItemPreviewCard(
                              quotationItem: email,
                              onDelete: () =>
                                  appState.deleteQuotationItem(index),
                              index: index,
                              callback: appState.updateQuotationItem);
                          // return MailPreviewCard(
                          //   id: email.id,
                          //   email: email,
                          //   isStarred: model.isEmailStarred(email.id),
                          //   onDelete: () => model.deleteEmail(email.id),
                          //   onStar: () => model.starEmail(email.id),
                          //   onStarredMailbox: model.selectedMailboxPage ==
                          //       MailboxPageType.starred,
                          // );
                        },
                      ),
              ),
              if (isDesktop) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 14),
                  child: Row(
                    children: [
                      IconButton(
                        key: const ValueKey('ReplySearch'),
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Provider.of<ApplicationState>(
                          //   context,
                          //   listen: false,
                          // ).onSearchPage = true;
                        },
                      ),
                      SizedBox(width: isTablet ? 30 : 60),
                    ],
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
