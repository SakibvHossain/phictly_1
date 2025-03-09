import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class BookSearchBar extends StatelessWidget {
  const BookSearchBar({super.key, required this.yourAction, this.readOnly});

  final Callback yourAction;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: readOnly ?? true, // Prevents typing in this field
                onTap: yourAction,
                decoration: InputDecoration(
                  hintText: '   Search',
                  hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff636F85)),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(14.0),
                    // Adjust padding as needed
                    child: Image.asset(
                      'assets/book/search_book.png',
                      // Use custom image as leading icon
                      width: 10,
                      height: 10,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}