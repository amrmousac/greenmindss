import 'package:flutter/material.dart';
import 'package:greenminds/models/list_model.dart';
import 'package:greenminds/providers/filter_companies.dart';
import 'package:greenminds/screen/company_details.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';

class FilterCompaniesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<CompaniesFilterProvider>(context);
    bool check = (filterProvider.name == '' &&
        filterProvider.city == '' &&
        filterProvider.country == '');
    print(
        'name = ${filterProvider.name} city = ${filterProvider.city} country = ${filterProvider.country}');
    return check
        ? Container()
        : Container(
            child: PaginationView<ListModel>(
              bottomLoader: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              initialLoader: Center(
                child: CircularProgressIndicator(),
              ),
              onError: (dynamic error) => Center(
                child: Center(child: Text('Some error occured ')),
              ),
              onEmpty: Center(
                child: Text('No Data'),
              ),
              pageFetch: filterProvider.companiesFilterList,
              itemBuilder:
                  (BuildContext context, ListModel company, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4.0),
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CompanyDetailsScreen(company.id))),
                      child: Container(
                          margin: EdgeInsets.all(2.0),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 8.0,
                              spreadRadius: 2.0,
                            ),
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Text(
                              company.name,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            )),
                          ))),
                );
              },
            ),
          );
  }
}
