#.rst:
# add file filter to visual studio

macro(add_vs_filter source_files)
    if(WIN32)
        set(sgbd_cur_dir ${CMAKE_CURRENT_SOURCE_DIR})
        foreach(sgbd_file ${${source_files}})			
			string(REPLACE ${sgbd_cur_dir}/  "" groupName1 ${sgbd_file})			
			string(REGEX REPLACE  \(/?[^/]+$\) "" groupName2  ${groupName1})			
			#组名不空
			if(groupName2)
				string(REPLACE "/" "\\\\" groupName3 ${groupName2})
				#message(STATUS ${groupName3})
			else()  #组名为空串
				#头文件
				string(REGEX MATCH \(\(\\.hpp\)|\(\\.h\)\)$  ext1  ${groupName1} )				
				string(REGEX MATCH \(\(\\.c\)|\(\\.cpp\)|\(\\.cpp\)\)$ ext2 ${groupName1})				
				if(ext1)
					set(groupName3 "Header Files")
				elseif(ext2)
				#source file
					set(groupName3 "Source Files")				
				else()
					set(groupName3 "Z-Misc Files")
				endif()				
			endif()					
            source_group(${groupName3} FILES ${sgbd_file})
        endforeach(sgbd_file)
    endif(WIN32)
endmacro(add_vs_filter)