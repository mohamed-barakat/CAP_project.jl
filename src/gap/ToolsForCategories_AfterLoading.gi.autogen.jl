# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

## This file contains installations for ToolsForCategories functions
## that can only be installed after all dependencies have been loaded.

if IsPackageMarkedForLoading( "Browse", ">=0" ) && IsBound( NCurses ) && IsBound( NCurses.BrowseDenseList )

    @InstallGlobalFunction( BrowseCachingStatistic,
      
      function( category )
        local operations, current_cache_name, current_cache, value_matrix, names, cols, current_list;
        
        value_matrix = [ ];
        names = [ ];
        cols = [ [ "status", "hits", "misses", "stored" ] ];
        
        operations = ShallowCopy( RecNames( category.caches ) );
        Sort( operations );
        
        for current_cache_name in operations
            Add( names, [ current_cache_name ] );
            if !IsBound( category.caches[current_cache_name] )
                Add( value_matrix, [ "!installed", "-", "-", "-" ] );
                continue;
            end;
            current_cache = category.caches[current_cache_name];
            if current_cache == "none" || IsDisabledCache( current_cache )
                Add( value_matrix, [ "deactivated", "-", "-", "-" ] );
                continue;
            end;
            current_list = [ ];
            if IsWeakCache( current_cache )
                Add( current_list, "weak" );
            elseif IsCrispCache( current_cache )
                Add( current_list, "crisp" );
            end;
            
            Append( current_list, [ current_cache.hit_counter, current_cache.miss_counter, Length( PositionsProperty( current_cache.value, ReturnTrue ) ) ] );
            Add( value_matrix, current_list );
        end;
        
        NCurses.BrowseDenseList( value_matrix, rec( labelsCol = cols, labelsRow = names ) );
        
    end );

end;

##
@InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY,
  
  function( cell, category, human_readable_identifier_list )
    local generic_help_string;
    
    generic_help_string = " You can access the category cell && category via the local variables 'cell' && 'category' ⥉ a break loop.";
    
    if !IsCapCategoryCell( cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the filter IsCapCategoryCell.", generic_help_string ] ) );
    end;
    
    if !HasCapCategory( cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no CAP category.", generic_help_string ] ) );
    end;
    
    if category != false && !IsIdenticalObj( CapCategory( cell ), category )
        CallFuncList( Error, @Concatenation( [ "The CapCategory of " ], human_readable_identifier_list, [ " is !identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
end );

##
@InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY,
  
  function( object, category, human_readable_identifier_list )
    local generic_help_string;
    
    generic_help_string = " You can access the object && category via the local variables 'object' && 'category' ⥉ a break loop.";
    
    if !IsCapCategoryObject( object )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the filter IsCapCategoryObject.", generic_help_string ] ) );
    end;
    
    if !HasCapCategory( object )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no CAP category.", generic_help_string ] ) );
    end;
    
    if category != false && !IsIdenticalObj( CapCategory( object ), category )
        CallFuncList( Error, @Concatenation( [ "The CapCategory of " ], human_readable_identifier_list, [ " is !identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
    if category != false && !ObjectFilter( category )( object )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the object filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
end );

##
@InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY,
  
  function( morphism, category, human_readable_identifier_list )
    local generic_help_string;
    
    generic_help_string = " You can access the morphism && category via the local variables 'morphism' && 'category' ⥉ a break loop.";
    
    if !IsCapCategoryMorphism( morphism )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the filter IsCapCategoryMorphism.", generic_help_string ] ) );
    end;
    
    if !HasCapCategory( morphism )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no CAP category.", generic_help_string ] ) );
    end;
    
    if category != false && !IsIdenticalObj( CapCategory( morphism ), category )
        CallFuncList( Error, @Concatenation( [ "the CAP-category of " ], human_readable_identifier_list, [ " is !identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
    if category != false && !MorphismFilter( category )( morphism )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the morphism filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
    if !HasSource( morphism )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no source.", generic_help_string ] ) );
    end;
    
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( Source( morphism ), category, @Concatenation( [ "the source of " ], human_readable_identifier_list ) );
    
    if !HasRange( morphism )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no range.", generic_help_string ] ) );
    end;
    
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( Range( morphism ), category, @Concatenation( [ "the range of " ], human_readable_identifier_list ) );
    
end );

##
@InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY,
  
  function( two_cell, category, human_readable_identifier_list )
    local generic_help_string;
    
    generic_help_string = " You can access the 2-cell && category via the local variables 'two_cell' && 'category' ⥉ a break loop.";
    
    if !IsCapCategoryTwoCell( two_cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the filter IsCapCategoryTwoCell.", generic_help_string ] ) );
    end;
    
    if !HasCapCategory( two_cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no CAP category.", generic_help_string ] ) );
    end;
    
    if category != false && !IsIdenticalObj( CapCategory( two_cell ), category )
        CallFuncList( Error, @Concatenation( [ "the CapCategory of " ], human_readable_identifier_list, [ " is !identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
    if category != false && !TwoCellFilter( category )( two_cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " does !lie ⥉ the 2-cell filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ] ) );
    end;
    
    if !HasSource( two_cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no source.", generic_help_string ] ) );
    end;
    
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( Source( two_cell ), category, @Concatenation( [ "the source of " ], human_readable_identifier_list ) );
    
    if !HasRange( two_cell )
        CallFuncList( Error, @Concatenation( human_readable_identifier_list, [ " has no range.", generic_help_string ] ) );
    end;
    
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( Range( two_cell ), category, @Concatenation( [ "the range of " ], human_readable_identifier_list ) );
    
end );

##
@InstallGlobalFunction( PackageOfCAPOperation, function ( operation_name )
  local packages;
    
    if !IsBound( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name] )
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( operation_name, " is !a CAP operation" );
        
    end;
    
    packages = Filtered( RecNames( CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE ), package -> IsBound( CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE[package][operation_name] ) );
    
    if Length( packages ) == 0
        
        return fail;
        
    elseif Length( packages ) > 1
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Found multiple packages for CAP operation ", operation_name );
        
    end;
    
    return packages[1];
    
end );
